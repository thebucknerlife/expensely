import React, { PropTypes } from 'react';
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

  render() {
    return (
      <div>
        <RequestForm items={this.state.request.items}/>
      </div>
    );
  }
}

Request.propTypes = {
  items: PropTypes.array,
};

