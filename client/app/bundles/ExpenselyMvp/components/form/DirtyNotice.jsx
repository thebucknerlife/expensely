import React, { PropTypes } from 'react';

export default function DirtyNotice({ dirty }) {
  if (dirty) {
    return(<div className={'dirty-notice'}>You have unsaved changes</div>);
  } else {
    return(<div className={'dirty-notice'}>Saved</div>);
  }
}
