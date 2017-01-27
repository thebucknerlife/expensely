import axios from 'axios';
import qs from 'qs';
import { deepSnakeCaseKeys, deepCamelCaseKeys } from './caseHelpers';
import renameKey from 'rename-key';

function request(url, method, data, params) {
  return axios.request({
    url,
    method,
    data,
    params,
    transformRequest: [
      (data) => {
        return qs.stringify(deepSnakeCaseKeys(data));
      },
    ],
    transformResponse: [
      (data) => {
        return deepCamelCaseKeys(JSON.parse(data));
      },
    ]
  })
}

function put(url, data={}, params = {}) {
  return request(url, 'put', data, params)
}

function post(url, data={}, params = {}) {
  console.log(url, data);
  return request(url, 'post', data, params)
}

function patchFile(url, data, params = {}) {
  return axios.request({ url, method: 'patch', data, params })
}

export default {
  requestItems: {
    create: (params) => post('/request_items', { request_item: params })
  },
  requests: {
    update: (params) => {
      var requestParams = Object.assign({}, params);
      renameKey(requestParams, 'requestItems', 'requestItemsAttributes');
      return put(`/requests/${requestParams.id}`, { request: requestParams })
    }
  },
  receipts: {
    create: (params) => post('/receipts', params),
    update: (data, params) => patchFile(`/receipts/${params.id}`, data)
  }
}

