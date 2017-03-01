import React, { PropTypes } from 'react';
import changeCase from 'change-case';
import RequestForm from '../components/RequestForm';
import FileDropzone from '../components/FileDropzone';
import upload from '../utils/upload';
import api from '../utils/api';
import { findIndex } from 'lodash';
const pdfPlaceholderUrl = require('assets/pdf_placeholder.svg');

export default class Request extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      request: props.request,
      formDirty: false,
      token: props.token,
    };
  }

  onDrop = (files) => {
    files.forEach((file) => {
      let receiptId = null;
      api.receipts.create().then((resp) => {
        receiptId = resp.data.id;
        this.newRequestItem({
          receiptId,
          description: file.name,
          preview: file.type == 'application/pdf' ? ('/assets' + pdfPlaceholderUrl) : file.preview,
        })
        upload(file, resp.data).then((resp) => {
          let index = findIndex(this.state.request.requestItems, ['receiptId', receiptId])
          this.updateRequestItem({ receipt: resp.data }, index);
        });
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

  deleteRequestItem = (index) => {
    this.updateRequestItem({'_destroy': true}, index);
  }

  handleSubmit = (e) => {
    e.preventDefault();
    let newAttrs = Object.assign(this.state.request, { submittedAt: new Date().toISOString() });
    api.requests.update(newAttrs, this.state.token)
      .then((response) => {
        Object.assign(this.state.request, response.data)
        this.state.formDirty = false;
        this.setState(this.state);
      });
  }

  handleSave = (e) => {
    e.preventDefault();
    api.requests.update(this.state.request, this.state.token)
      .then((response) => {
        Object.assign(this.state.request, response.data)
        this.state.formDirty = false;
        this.setState(this.state);
      });
  }

  render() {
    return (
      <div>
        <RequestForm
          request={this.state.request}
          updateRequest={this.updateRequest}
          updateRequestItem={this.updateRequestItem}
          handleSubmit={this.handleSubmit}
          handleSave={this.handleSave}
          deleteRequestItem={this.deleteRequestItem}
          dirty={this.state.formDirty}
          onDrop={this.onDrop}
        />
        <FileDropzone onDrop={this.onDrop}/>
      </div>
    );
  }
}

Request.propTypes = {
  requestItems: PropTypes.array,
};

