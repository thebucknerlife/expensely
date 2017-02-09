import React, { PropTypes } from 'react';
import classnames from 'classnames';
const spinnerUrl = require('assets/rolling.svg');

const Image = ({ src, loadingPreview }) => {
  const spinnerClass = classnames('spinner')
  const srcUrl = (loadingPreview || src);
  const divStyle = { backgroundImage: 'url(' + srcUrl + ')' };
  let spinner = null;

  if (src === undefined) {
    spinner = (<div className={"spinner"}>
      <img src={'/assets' + spinnerUrl}/>
    </div>)
  }

  return (
    <div className={'image__container'}>
      <div className={'image__frame'} style={divStyle}>
      </div>
      { spinner }
    </div>
  )
}

export default Image;
