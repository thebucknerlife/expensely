import React, { PropTypes } from 'react';
import changeCase from 'change-case';
import RequestForm from '../components/RequestForm';
import FileDropzone from '../components/FileDropzone';
import upload from '../utils/upload';
import api from '../utils/api';

export default class Request extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      request: props.request,
      formDirty: false
    };
  }

  onDrop = (files) => {
    files.forEach((file) => {
      api.receipts.create().then((resp) => {
        console.log('resp', resp);
        this.newRequestItem({
          receipt_id: resp.data.id,
          description: file.name,
          preview: file.preview,
        })
        upload(file, resp.data);
      })
    })
  }

  newRequestItem = (requestItem) => {
    this.state.request.requestItems.push(requestItem);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  updateRequest = (newAttrs) => {
    Object.assign(this.state.request, newAttrs);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  updateRequestItem = (newAttrs, index) => {
    Object.assign(this.state.request.requestItems[index], newAttrs);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  handleSubmit = (e) => {
    console.log('submit');
    e.preventDefault();
    api.requests.update(Object.assign(this.state.request, { submittedAt: new Date() }))
      .then((response) => {
        Object.assign(this.state.request, response.data)
        this.state.formDirty = false;
        this.setState(this.state);
      });
  }

  handleSave = (e) => {
    console.log('save');
    e.preventDefault();
    api.requests.update(this.state.request)
      .then((response) => {
        Object.assign(this.state.request, response.data)
        this.state.formDirty = false;
        this.setState(this.state);
      });
  }

  render() {
    return (
      <div>
        <FileDropzone onDrop={this.onDrop}/>
        <RequestForm
          request={this.state.request}
          updateRequest={this.updateRequest}
          updateRequestItem={this.updateRequestItem}
          handleSubmit={this.handleSubmit}
          handleSave={this.handleSave}
          dirty={this.state.formDirty}
        />
        <FileDropzone onDrop={this.onDrop}/>
      </div>
    );
  }
}

Request.propTypes = {
  requestItems: PropTypes.array,
};
