import React, { PropTypes } from 'react';
import RequestItem from './RequestItem';

const RequestForm = ({items, updateItem}) => {
  console.log(items);

  const itemsNodes = items.map((item, index) => {
    return (<RequestItem 
        name={item.name}
        preview={item.preview}
        key={index}
        index={index}
        updateItem={updateItem}
      />
    );
  });
  
  return (
    <div>
      <form>
        { itemsNodes }
        <input
          type="submit"
        />
      </form>
    </div>
  );
}

Request.propTypes = {
  items: PropTypes.array,
};

export default RequestForm;
