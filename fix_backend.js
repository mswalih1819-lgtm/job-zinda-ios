const fs = require('fs');
const filePath = 'c:\\Users\\AhmedThousifAktharHa\\Documents\\personal Projects\\jobzinda\\job-zinda-backend\\src\\services\\user-service.ts';
let content = fs.readFileSync(filePath, 'utf8');

// Detect line ending style
const lineEnding = content.includes('\r\n') ? '\r\n' : '\n';
const nl = lineEnding;

// Part 1: Insert nullable field detection BEFORE trasformObj call
const oldPart1 = [
  'const updateProfileDetails = async (obj: any): Promise<IUser | null> => {',
  '  let transformedObj: any = trasformObj(obj);',
].join(nl);

const newPart1 = [
  'const updateProfileDetails = async (obj: any): Promise<IUser | null> => {',
  '  // Capture fields that should be unset (removed from DB) when the client sends null.',
  '  // trasformObj() strips null/undefined keys, so we must detect them before that call.',
  "  const nullableFields = ['contactNumber', 'whatsappNumber', 'whatsappLink', 'directCallLink'];",
  '  const fieldsToUnset: Record<string, string> = {};',
  '  for (const field of nullableFields) {',
  '    if (Object.prototype.hasOwnProperty.call(obj, field) && (obj[field] === null || obj[field] === undefined)) {',
  "      fieldsToUnset[field] = '';",
  '    }',
  '  }',
  '',
  '  let transformedObj: any = trasformObj(obj);',
].join(nl);

if (content.includes(oldPart1)) {
  content = content.replace(oldPart1, newPart1);
  console.log('Part 1 applied successfully');
} else {
  console.log('ERROR: Part 1 target NOT FOUND');
  process.exit(1);
}

// Part 2: Add $unset before updateUserData call in the try block
const oldPart2 = [
  '  try {',
  '    return await userRepository.updateUserData(transformedObj.userId, transformedObj);',
].join(nl);

const newPart2 = [
  '  try {',
  '    // If any nullable fields were sent as null, use $unset to remove them from MongoDB.',
  '    // Without this, trasformObj strips them and MongoDB keeps the old values.',
  '    if (Object.keys(fieldsToUnset).length > 0) {',
  '      transformedObj["$unset"] = fieldsToUnset;',
  '    }',
  '',
  '    return await userRepository.updateUserData(transformedObj.userId, transformedObj);',
].join(nl);

// Find the RIGHT occurrence - the one inside updateProfileDetails (first try block)
const firstTryIndex = content.indexOf(oldPart2);
if (firstTryIndex !== -1) {
  content = content.substring(0, firstTryIndex) + newPart2 + content.substring(firstTryIndex + oldPart2.length);
  console.log('Part 2 applied successfully');
} else {
  console.log('ERROR: Part 2 target NOT FOUND');
  process.exit(1);
}

fs.writeFileSync(filePath, content, 'utf8');
console.log('File saved successfully!');
