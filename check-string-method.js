// const str = 'ABCDEZXY';
// const str = 'abcdezxy';
// const str = 'AbCdEzXy';
const str = 'A1b2C3d4/+*';

const returnChecked = {
  invalidInput: 'Invalid Input',
  allCapitalLetter: 'All Capital Letter',
  allSmallLetter: 'All Small Letter',
  mix: 'Mix',
}

function checkString(str) {

  let returnString = '';
  const invlidPatern = /^[A-Za-z0-9 ]+$/

  if (!invlidPatern.test(str)) {
    returnString = returnChecked.invalidInput;
    return returnString;
  }

  if (!/[a-z]/.test(str) && /[A-Z]/.test(str)) {
    returnString = returnChecked.allCapitalLetter;
  } else if (/[a-z]/.test(str) && !/[A-Z]/.test(str)) {
    returnString = returnChecked.allSmallLetter;
  } else if (/[a-z]/.test(str) && /[A-Z]/.test(str)) {
    returnString = returnChecked.mix;
  }
  return returnString;
}

console.log(checkString(str));