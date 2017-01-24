import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';

const RequestForm = ({updateRequest, request, updateRequestItem, handleSubmit, dirty}) => {

  const requestItemNodes = request.requestItems.map((requestItem, index) => {
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
    if (props.dirty) {
      return(<div>You have unsaved changes</div>);
    } else {
      return(<div>Saved</div>);
    }
  }

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <input
          className="name"
          type="text"
          placeholder="request name"
          value={request.name}
          onChange={(e) => {
            updateRequest({ name: e.target.value })
          }}
        />
        { requestItemNodes }
        <DirtyNotice dirty={dirty}/>
        <input
          className={"btn btn-success"}
          type="submit"
          value="Save"
        />
      </form>
    </div>
  );
}

Request.propTypes = {
  request: PropTypes.object,
};

export default RequestForm;
