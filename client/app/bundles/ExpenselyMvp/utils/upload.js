import api from './api';

export default function upload(file, params) {
  let data = new FormData()
  data.append('file', file)
  api.receipts.update(data, params)
};
