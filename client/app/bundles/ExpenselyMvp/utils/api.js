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
    transformRequest: [ transformRequest ],
    transformResponse: [ transformResponse ],
  })
}

function put(url, data={}, params = {}) {
  return request(url, 'put', data, params)
}

function post(url, data={}, params = {}) {
  return request(url, 'post', data, params)
}

function patchFile(url, data, params = {}) {
  return axios.request({ url, method: 'patch', data, params, transformResponse: [ transformResponse ] })
}

function transformRequest(data) {
  return qs.stringify(deepSnakeCaseKeys(data));
}

function transformResponse(data) {
  return deepCamelCaseKeys(JSON.parse(data));
}

export default {
  requestItems: {
    create: (params) => post('/request_items', { request_item: params })
  },
  requests: {
    update: (params, token) => {
      var requestParams = Object.assign({}, params);
      renameKey(requestParams, 'requestItems', 'requestItemsAttributes');
      return put(`/requests/${requestParams.id}`, { request: requestParams }, { token: token })
    }
  },
  receipts: {
    create: (params) => post('/receipts', params),
    update: (data, params) => patchFile(`/receipts/${params.id}`, data)
  }
}

