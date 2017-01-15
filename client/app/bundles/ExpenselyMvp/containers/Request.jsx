import React, { PropTypes } from 'react';
import update from 'immutability-helper';
import RequestForm from '../components/RequestForm';
import FileDropzone from '../components/FileDropzone';

export default class Request extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = {
      request: {
        items: [],
      }
    };
  }

  onDrop = (files) => {
    files.forEach((file) => {
      console.log(file);
      this.newItem({
        name: file.name,
        preview: file.preview
      })
    })
  }

  newItem = (item) => {
    this.state.request.items.push(item);
    this.setState(this.state);
  }

  updateItem = (newAttrs, index) => {
    Object.assign(this.state.request.items[index], newAttrs);
    this.setState(this.state);
  }

  render() {
    return (
      <div>
        <FileDropzone onDrop={this.onDrop}/>
        <RequestForm
          items={this.state.request.items}
          updateItem={this.updateItem}
        />
      </div>
    );
  }
}

Request.propTypes = {
  items: PropTypes.array,
};

