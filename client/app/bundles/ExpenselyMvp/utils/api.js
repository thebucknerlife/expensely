import axios from 'axios';
import qs from 'qs';
import snakecaseKeys from 'snakecase-keys';
import camelcaseKeys from 'camelcase-keys';
import renameKey from 'rename-key';

function request(url, method, data, params) {
  return axios.request({
    url,
    method,
    data,
    params,
    transformRequest: [
      (data) => {
        return qs.stringify(snakecaseKeys(data));
      },
    ],
    transformResponse: [
      (data) => {
        return camelcaseKeys(JSON.parse(data));
      },
    ]
  })
}

function put(url, data={}, params = {}) {
  return request(url, 'put', data, params)
}

function post(url, data={}, params = {}) {
  return request(url, 'post', data, params)
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
  }
}

