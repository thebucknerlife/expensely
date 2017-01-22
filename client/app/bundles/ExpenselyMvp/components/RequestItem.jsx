import React, { PropTypes } from 'react';

const RequestItem = ({index, update, ...props}) => {
  return (
    <div>
      <img
        className={'request-item--image'}
        src={props.preview}
      />
      <input
        className={`description-${index}`}
        type="text"
        placeholder="description"
        value={props.description}
        onChange={(e) => {
          update({ description: e.target.value }, index)
        }}
      />
      <input
        className={`category-${index}`}
        type="text"
        placeholder="category"
        value={props.category}
        onChange={(e) => {
          update({ category: e.target.value }, index)
        }}
      />
      <input
        className={`amount-${index}`}
        type="number"
        placeholder="amount"
        value={props.amount}
        onChange={(e) => {
          update({ amount: e.target.value }, index)
        }}
      />
    </div>
  );
}

RequestItem.propTypes = {
  description: PropTypes.string,
  type: PropTypes.string,
  amount: PropTypes.number,
  update: PropTypes.func.isRequired,
};

RequestItem.defaultProps = {
  description: '',
  type: '',
  amount: 0
}

export default RequestItem;
