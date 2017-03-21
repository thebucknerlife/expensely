import React, { PropTypes } from 'react';
import RequestItem from '../RequestItem';
import FileDropzone from '../FileDropzone';
import RequestName from './RequestName';
import Submit from './Submit';
import { reqAttrsToFormAttrs, invalidate } from '../../utils/formHelpers';
import { reqSugs } from '../../utils/suggestionsHelpers';

export default function RequestForm({updateRequest, request, updateRequestItem, deleteRequestItem, handleSave, handleSubmit, dirty, onDrop})  {
  const suggestions = reqSugs(request);

  const formAttrs = reqAttrsToFormAttrs(request);
  const v = invalidate(formAttrs);
  console.log('formAttrs', formAttrs, 'v', v);

  const requestItemNodes = formAttrs.requestItems.map((requestItem, index) => {
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

