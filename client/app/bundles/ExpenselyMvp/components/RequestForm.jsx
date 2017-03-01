import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';
import FileDropzone from './FileDropzone';
import { union, compact } from 'lodash';

export default function RequestForm({updateRequest, request, updateRequestItem, deleteRequestItem, handleSave, handleSubmit, dirty, onDrop})  {
  const suggestions = handleSuggestions(request);
  const requestItemNodes = request.requestItems.map((requestItem, index) => {
    if (requestItem._destroy) return null;

    return (<RequestItem
        description={requestItem.description}
        amount={requestItem.amount}
        category={requestItem.category}
        paidAt={requestItem.paidAt}
        preview={requestItem.preview}
        receipt={requestItem.receipt}
        key={index}
        index={index}
        update={updateRequestItem}
        delete={deleteRequestItem}
        submittable={!request.submittedAt}
        suggestions={suggestions}
      />
    );
  });

  return (
    <div>
      <form onSubmit={handleSave}>
        <FileDropzone onDrop={onDrop} submittable={!request.submittedAt}/>
        <div className={"form-group"} >
          <RequestName
            submittable={!request.submittedAt}
            request={request}
            updateRequest={updateRequest}
          />
        </div>
        { requestItemNodes }
        <Submit
          handleSubmit={handleSubmit}
          handleSave={handleSave}
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

function DirtyNotice({ dirty }) {
  if (dirty) {
    return(<div className={'dirty-notice'}>You have unsaved changes</div>);
  } else {
    return(<div className={'dirty-notice'}>Saved</div>);
  }
}

function Submit({ submittable, handleSave, handleSubmit, dirty }) {
  if (!submittable) { return <span> This reimbursement has been submitted!  </span>}

  return (
    <div className="submit-container">
      <DirtyNotice dirty={dirty} />
      <input
        className={"btn btn-primary btn-lrg"}
        type="submit"
        value="Save"
        onClick={handleSave}
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

function RequestName({ submittable, request, updateRequest }) {
  if (submittable) {
    return (
      <input
        className="name form-control"
        type="text"
        placeholder="What is the name of your reimbursement request?"
        value={request.name}
        onChange={(e) => {
          updateRequest({ name: e.target.value })
        }}
      />
    )
  } else {
    return <h3>{request.name}</h3>
  }
}

function handleSuggestions(request) {
  let suggestions = { paidAt: [] };
  request.requestItems.reduce((sug, item) => {
    sug['paidAt'] = compact(union(sug['paidAt'], [item.paidAt]));
    return sug;
  }, suggestions);
  console.log('**suggestions', suggestions);
  return suggestions;
}
