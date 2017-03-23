import React, { PropTypes } from 'react';
import changeCase from 'change-case';
import RequestForm from '../components/form/RequestForm';
import FileDropzone from '../components/FileDropzone';
import upload from '../utils/upload';
import api from '../utils/api';
import moment from 'moment';
import { findIndex, reduce } from 'lodash';
import { formDataFromRequest, validateAndSetErrors, hasErrors } from '../utils/formHelpers';
const pdfPlaceholderUrl = require('assets/pdf_placeholder.svg');

export default class Request extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      formData: formDataFromRequest(props.request),
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
          description: { val: file.name },
          amount: { val: 0 },
          paidAt: { val: moment().format('YYYY-MM-DD') },
          category: { val: 'none' },
          preview: file.type == 'application/pdf' ? ('/assets' + pdfPlaceholderUrl) : file.preview,
        })
        upload(file, resp.data).then((resp) => {
          let index = findIndex(this.state.formData.requestItems, ['receiptId', receiptId])
          this.updateRequestItem({ receipt: resp.data }, index);
        });
      })
    })
  }

  updateRequest = (newAttrs) => {
    Object.assign(this.state.formData, newAttrs);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  newRequestItem = (requestItem) => {
    this.state.formData.requestItems.push(requestItem);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  updateRequestItem = (newAttrs, index) => {
    Object.assign(this.state.formData.requestItems[index], newAttrs);
    this.state.formDirty = true;
    this.setState(this.state);
  }

  deleteRequestItem = (index) => {
    this.updateRequestItem({'_destroy': true}, index);
  }

  apiUpdate = (attrs) => {
    api.requests.update(attrs, this.state.token)
      .then((response) => {
        Object.assign(this.state.formData, response.data)
        this.state.formDirty = false;
        this.setState(this.state);
      });
  }

  handleSubmit = (e) => {
    e.preventDefault();
    let newAttrs = Object.assign(this.state.formData, { submittedAt: new Date().toISOString() });
    this.apiUpdate(newAttrs);
  }

  handleSave = (e) => {
    e.preventDefault();

    const newFormData = validateAndSetErrors(this.state.formData)
    console.log('newFormData', newFormData);
    console.log('errors?', hasErrors(newFormData));

    this.state.formData = newFormData;

    this.setState(this.state);
    //this.apiUpdate(this.state.formData);
  }

  render() {
    return (
      <div>
        <RequestForm
          data={this.state.formData}
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

