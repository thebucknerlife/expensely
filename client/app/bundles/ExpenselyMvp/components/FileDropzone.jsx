import React, { PropTypes } from 'react';
import Dropzone from 'react-dropzone';

const FileDropzone = ({ onDrop, submittable }) => {
  if(!submittable) { return null };

  return (
    <Dropzone
      onDrop={onDrop}
      className={"dropzone"}
      activeClassName={"dropzone--active"}
    >
      <div>Drag and drop receipts here for upload. You can also click to see the normal file dialog window.</div>
    </Dropzone>
  )
}

export default FileDropzone;
