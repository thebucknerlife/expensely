import React, { PropTypes } from 'react';

const RequestForm = ({items}) => {
  return (
    <div>
      <form >
        { items.length }
      </form>
    </div>
  );
}

Request.propTypes = {
  items: PropTypes.array,
};

export default RequestForm;
