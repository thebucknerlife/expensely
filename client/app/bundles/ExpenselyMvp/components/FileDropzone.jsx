import React, { PropTypes } from 'react';
import Dropzone from 'react-dropzone';

const FileDropzone = ({ onDrop }) => {
  return (
    <Dropzone onDrop={onDrop}>
      <div>Drag and drop receipts here for upload. You can also click to see the normal file dialog window.</div>
    </Dropzone>
  )
}

export default FileDropzone;
