import React, { PropTypes } from 'react';
import RequestItem from '../RequestItem';
import FileDropzone from '../FileDropzone';
import RequestName from './RequestName';
import Submit from './Submit';
import { union, compact } from 'lodash';

export default function RequestForm({updateRequest, request, updateRequestItem, deleteRequestItem, handleSave, handleSubmit, dirty, onDrop})  {
  const suggestions = handleSuggestions(request);
  const requestItemNodes = request.requestItems.map((requestItem, index) => {
    if (requestItem._destroy) return null;

    return (<RequestItem
        key={index}
        index={index}
        update={updateRequestItem}
        delete={deleteRequestItem}
        submittable={!request.submittedAt}
        suggestions={suggestions}
        { ...requestItem }
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

function handleSuggestions(request) {
  let suggestions = { paidAt: [] };
  request.requestItems.reduce((sug, item) => {
    sug['paidAt'] = compact(union(sug['paidAt'], [item.paidAt]));
    return sug;
  }, suggestions);
  return suggestions;
}
