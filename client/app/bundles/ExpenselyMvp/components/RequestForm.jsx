import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';

const RequestForm = ({requestItems, updateRequestItem, handleSubmit}) => {
  console.log(requestItems);

  const requestItemNodes = requestItems.map((requestItem, index) => {
    return (<RequestItem
        description={requestItem.description}
        amount={requestItem.amount}
        category={requestItem.category}
        preview={requestItem.preview}
        key={index}
        index={index}
        update={updateRequestItem}
      />
    );
  });

  return (
    <div>
      <form onSubmit={handleSubmit}>
        { requestItemNodes }
        <input
          type="submit"
          value="Save"
        />
      </form>
    </div>
  );
}

Request.propTypes = {
  requestItems: PropTypes.array,
};

export default RequestForm;
