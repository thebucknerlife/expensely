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
      upload(file);
      this.newRequestItem({
        description: file.name,
        preview: file.preview,
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
          dirty={this.state.formDirty}
        />
      </div>
    );
  }
}

Request.propTypes = {
  requestItems: PropTypes.array,
};
