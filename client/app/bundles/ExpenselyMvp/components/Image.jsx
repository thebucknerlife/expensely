import React, { PropTypes } from 'react';
import classnames from 'classnames';
const spinnerUrl = require('assets/rolling.svg');

const Image = ({ src, loadingPreview, file }) => {
  const srcUrl = (src || loadingPreview);
  const divStyle = { backgroundImage: 'url(' + srcUrl + ')' };

  return (
    <Wrapper href={ file }>
      <div className={'image__container'}>
        <div className={'image__frame'} style={divStyle}>
        </div>
        { src ? null : <Spinner/> }
      </div>
    </Wrapper>
  )
}

export default Image;

function Spinner() {
  return (
    <div className={"spinner"}>
      <img src={'/assets' + spinnerUrl}/>
    </div>
  )
}

function Wrapper({ children, href }) {
  if (href) {
    return (
      <a href={href} target={"_blank"} className={'image__link-wrapper'}>
        { children}
      </a>
    )
  } else {
    return children;
  }
}
