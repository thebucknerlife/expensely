import React, { PropTypes } from "react";
import { get, find } from "lodash";
import Image from './Image';

const RequestItem = ({index, update, submittable, ...props}) => {
  const fields = [
    { title: "Description", name: "description", type: "text" },
    { title: "Category", name: "category", type: "dropdown" },
    { title: "Amount", name: "amount", type: "money" },
  ]

  // todo: add support for float in number field, setup default value

  const fieldNodes = fields.map(({ title, name, type }) => {
    if(!submittable) return (
      <li className={"request-item__input-group"}>
        <label>{title}</label>
        <p>{props[name]}</p>
      </li>
    )


    if (type === 'dropdown') {
      return (
        <Dropdown
          index={index}
          key={name}
          update={update}
          title={title}
          name={name}
          { ...props }
        />
      )
    } else if (type === 'money') {
      return (
        <MoneyInput
          index={index}
          key={name}
          update={update}
          title={title}
          name={name}
          { ...props }
        />
      )
    } else {
      return (
        <BasicInput
          index={index}
          key={name}
          update={update}
          title={title}
          name={name}
          { ...props }
        />
      )
    }
  })

  return (
    <div className={"request-item"}>
      <div className={"request-item__image-container"}>
        <Image
          src={get(props, "receipt.thumbnailUrl")}
          file={get(props, "receipt.accountantUrl")}
          loadingPreview={props.preview}
        />
      </div>
      <div className={"request-item__inputs-container"}>
        <div className={"request-item__delete"}>
          <span className={"delete-icon"} onClick={() => { props.delete(index) }}>&#10006;</span>
        </div>
        <ul className={"request-item__inputs"}>
          { fieldNodes }
        </ul>
      </div>
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

function MoneyInput({ name, title, type, update, index, ...props}) {
  let value = props[name] / 100;

  return (
    <li className={"request-item__input-group"}>
      <label>{title}</label>
      <input
        className={"request-item__input"}
        type={"number"}
        placeholder={title}
        value={value}
        onChange={(e) => {
          update({ [name]: (e.target.value * 100) }, index)
        }}
      />
    </li>
  )
}

function BasicInput({ name, title, type, update, index, ...props}) {
  return (
    <li className={"request-item__input-group"}>
      <label>{title}</label>
      <input
        className={"request-item__input"}
        type={"text"}
        placeholder={title}
        value={props[name]}
        onChange={(e) => {
          update({ [name]: e.target.value }, index)
        }}
      />
    </li>
  )
}

function Dropdown({ name, title, update, index, ...props}) {

  let optionNodes = options().map(({ name, value }) => {
    return (
      <option value={value} key={value}>{name}</option>
    )
  })

  return (
    <li className={"request-item__input-group"}>
      <label>{title}</label>
      <select
        className={"request-item__input"}
        value={props[name]}
        onChange={(e) => {
          update({ [name]: e.target.value }, index)
        }}
      >
        { optionNodes }
      </select>
    </li>
  )
}

function options() {
  return [
    {name: 'Select A Category', value: 'none'},
    {name: 'Meal', value: 'meal'},
    {name: 'Travel', value: 'travel'},
    {name: 'Phone', value: 'phone'},
    {name: 'Office Supplies', value: 'office_supplies'},
    {name: 'Postage', value: 'postage'},
    {name: 'Other', value: 'other'},
  ];
}
