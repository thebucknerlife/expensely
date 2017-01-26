import deepMapKeys from 'deep-map-keys';
import { snakeCase, camelCase } from 'lodash';

export function deepSnakeCaseKeys(obj) {
  return deepMapKeys(obj, key => snakeCase(key) );
}

export function deepCamelCaseKeys(obj) {
  return deepMapKeys(obj, key => camelCase(key) );
}
