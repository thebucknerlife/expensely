import React, { PropTypes } from "react";

const RequestItem = ({index, update, ...props}) => {
  const fields = [
    { title: "Description", name: "description", type: "text" },
    { title: "Category", name: "category", type: "text" },
    { title: "Amount", name: "amount", type: "number" },
  ]

  const fieldNodes = fields.map(({ title, name, type }) => {
      return (
        <li className={"request-item__input-group"}>
          <label>{title}</label>
          <input
            className={"request-item__input"}
            type={type}
            key={name}
            placeholder={title}
            value={props[name]}
            onChange={(e) => {
              update({ [name]: e.target.value }, index)
            }}
          />
        </li>
      )
  })

  return (
    <div className={"request-item"}>
      <img
        className={"request-item--image"}
        src={props.preview}
      />
      <ul className={"request-item--inputs"}>
        { fieldNodes }
      </ul>
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
  description: "",
  category: "",
  amount: 0
}

export default RequestItem;
