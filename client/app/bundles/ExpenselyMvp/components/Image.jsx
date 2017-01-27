import React, { PropTypes } from 'react';
import classnames from 'classnames';

const Image = ({ src, isLoading }) => {
  const divStyle = { backgroundImage: 'url(' + src + ')' };

  return (
    <div className={'image__container'}>
      <div className={'image__frame'} style={divStyle}>
      </div>
      <div className={"spinner"}>
        SPINNER
        <img src={spinner}/>
      </div>
    </div>
  )
}

export default Image;
