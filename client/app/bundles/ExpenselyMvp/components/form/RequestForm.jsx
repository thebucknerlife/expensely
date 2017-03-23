import React, { PropTypes } from 'react';
import RequestItem from '../RequestItem';
import FileDropzone from '../FileDropzone';
import RequestName from './RequestName';
import Submit from './Submit';
import { reqSugs } from '../../utils/suggestionsHelpers';

export default function RequestForm({updateRequest, data, updateRequestItem, deleteRequestItem, handleSave, handleSubmit, dirty, onDrop})  {
  const suggestions = reqSugs(data);
  const submittable = !data.submittedAt;

  const requestItemNodes = data.requestItems.map((requestItem, index) => {
    if (requestItem._destroy) return null;

    return (<RequestItem
        key={index}
        index={index}
        update={updateRequestItem}
        delete={deleteRequestItem}
        submittable={submittable}
        suggestions={suggestions}
        { ...requestItem }
      />
    );
  });

  return (
    <div>
      <form onSubmit={handleSave}>
        <FileDropzone onDrop={onDrop} submittable={submittable}/>
        <div className={"form-group"} >
          <RequestName
            submittable={submittable}
            request={data}
            updateRequest={updateRequest}
          />
        </div>
        { requestItemNodes }
        <Submit
          handleSubmit={handleSubmit}
          handleSave={handleSave}
          submittable={submittable}
          dirty={dirty}
        />
        <FileDropzone onDrop={onDrop} submittable={submittable}/>
      </form>
    </div>
  );
}

Request.propTypes = {
  data: PropTypes.object,
};

