import React, { PropTypes } from 'react';

export default class RequestForm extends React.Component {
  constructor(props, _railsContext) {
    super(props);
    this.state = { items: this.props.items };
  }

  render() {
    return (
      <div>
        <hr />
        <form >
          { this.props.items.length }
        </form>
      </div>
    );
  }
}

Request.propTypes = {
  items: PropTypes.array,
};

