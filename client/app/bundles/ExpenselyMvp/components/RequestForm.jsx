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
        <div className={"form-group"} >
          <input
            className="name form-control"
            type="text"
            placeholder="What is the name of your reimbursement request?"
            value={request.name}
            onChange={(e) => {
              updateRequest({ name: e.target.value })
            }}
          />
        </div>
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
    return(<div className={'dirty-notice'}>You have unsaved changes</div>);
  } else {
    return(<div className={'dirty-notice'}>Saved</div>);
  }
}

function Submit({ submittable, handleSubmit, dirty }) {
  if (!submittable) { return <span> This reimbursement has been submitted!  </span>}

  return (
    <div className="submit-container">
      <DirtyNotice dirty={dirty} />
      <input
        className={"btn btn-primary btn-lrg"}
        type="submit"
        value="Save"
      />
      <input
        className={"btn btn-success btn-lrg"}
        type="submit"
        value="Submit For Reimbursement"
        onClick={handleSubmit}
      />
    </div>
  );
}
