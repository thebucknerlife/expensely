import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';

const RequestForm = ({requestItems, updateRequestItem, handleSubmit, dirty}) => {
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

  function DirtyNotice(props) {
    if(props.dirty) {
      return(<div>You have unsaved changes</div>);
    } else {
      return(<div>Saved</div>);
    }
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        { requestItemNodes }
        <DirtyNotice dirty={dirty}/>
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
