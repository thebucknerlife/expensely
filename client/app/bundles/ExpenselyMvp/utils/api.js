import axios from 'axios';
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
        console.log('req data', data);
        //var snk = snakecaseKeys(data);
        var snk = data;
        console.log('returning', snk);
        return snk;
      },
    ],
    transformResponse: [
      (data) => {
        //console.log('resp data', data);
        //var cml = camelcaseKeys(data);
        var cml = data;
        //console.log('returning', cml);
        return cml;
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
      renameKey(requestParams, 'requestItems', 'requestItemAttributes');
      put(`/requests/${requestParams.id}`, { request: requestParams })
    }
  }
}

