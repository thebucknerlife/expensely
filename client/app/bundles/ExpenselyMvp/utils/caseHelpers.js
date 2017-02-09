import deepMapKeys from 'deep-map-keys';
import { snakeCase, camelCase } from 'lodash';

export function deepSnakeCaseKeys(obj) {
  return deepMapKeys(obj, (key) => {
    let leadingChar = key[0];
    let snakedKey = snakeCase(key);
    if (leadingChar == '_') {
      snakedKey = leadingChar + snakedKey;
    }
    return snakedKey;
  });
}

export function deepCamelCaseKeys(obj) {
  return deepMapKeys(obj, key => camelCase(key) );
}
