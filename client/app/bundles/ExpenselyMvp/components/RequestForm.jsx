import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';
import FileDropzone from './FileDropzone';

const RequestForm = ({updateRequest, request, updateRequestItem, handleSave, handleSubmit, dirty, onDrop}) => {

  const requestItemNodes = request.requestItems.map((requestItem, index) => {
    return (<RequestItem
        description={requestItem.description}
        amount={requestItem.amount}
        category={requestItem.category}
        preview={requestItem.preview}
        receipt={requestItem.receipt}
        key={index}
        index={index}
        update={updateRequestItem}
      />
    );
  });

  return (
    <div>
      <form onSubmit={handleSave}>
        <FileDropzone onDrop={onDrop} submittable={!request.submittedAt}/>
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
        <Submit
          handleSubmit={handleSubmit}
          submittable={!request.submittedAt}
          dirty={dirty}
        />
        <FileDropzone onDrop={onDrop} submittable={!request.submittedAt}/>
      </form>
    </div>
  );
}

Request.propTypes = {
  request: PropTypes.object,
};

export default RequestForm;

function DirtyNotice({ dirty }) {
  if (dirty) {
    return(<div>You have unsaved changes</div>);
  } else {
    return(<div>Saved</div>);
  }
}

function Submit({ submittable, handleSubmit, dirty }) {
  console.log(!submittable);

  if (!submittable) { return <span> This reimbursement has been submitted!  </span>}

  return (
    <div>
      <DirtyNotice dirty={dirty} />
      <input
        className={"btn btn-primary"}
        type="submit"
        value="Save"
      />
      <input
        className={"btn btn-success"}
        type="submit"
        value="Submit For Reimbursement"
        onClick={handleSubmit}
      />
    </div>
  );
}
