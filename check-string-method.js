// const str = 'ABCDEZXY';
// const str = 'abcdezxy';
// const str = 'AbCdEzXy';
const str = 'A1b2C3d4/+*';

function checkString(str) {

  let returnString = '';
  const invlidPatern = /^[A-Za-z0-9 ]+$/

  if (!invlidPatern.test(str)) {
    returnString = 'Invalid Input';
    return returnString;
  }

  if (!/[a-z]/.test(str) && /[A-Z]/.test(str)) {
    returnString = "All Capital Letter";
  } else if (/[a-z]/.test(str) && !/[A-Z]/.test(str)) {
    returnString = "All Small Letter";
  } else if (/[a-z]/.test(str) && /[A-Z]/.test(str)) {
    returnString = "Mix";
  }
  return returnString;
}

console.log(checkString(str));