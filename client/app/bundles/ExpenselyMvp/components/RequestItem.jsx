import React, { PropTypes } from 'react';

const RequestItem = ({index, updateItem, ...props}) => {
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
        value={props.name}
        onChange={(e) => {
          updateItem({ name: e.target.value }, index)
        }}
      />
      <input
        className={`type-${index}`}
        type="text"
        placeholder="type"
        value={props.type}
        onChange={(e) => {
          updateItem({ type: e.target.value }, index)
        }}
      />
      <input
        className={`amount-${index}`}
        type="number"
        placeholder="amount"
        value={props.amount}
        onChange={(e) => {
          updateItem({ amount: e.target.value }, index)
        }}
      />
    </div>
  );
}

RequestItem.propTypes = {
  name: PropTypes.string.isRequired,
  updateItem: PropTypes.func.isRequired,
};

export default RequestItem;
