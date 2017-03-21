import React, { PropTypes } from "react";
import classnames from 'classnames';
import { get, find } from "lodash";
import Image from './Image';
import DateInput from './DateInput';

const RequestItem = ({index, update, submittable, ...props}) => {
  let fieldNodes;

  if (submittable) {
    fieldNodes = [
      <BasicInput index={index} key='description' update={update} title='Description' name='description' val={props.description.val} error={props.description.error}/>,
      <Dropdown   index={index} key='category'    update={update} title='Category'    name='category'     { ...props } />,
      <MoneyInput index={index} key='amount'      update={update} title='Amount'      name='amount'       { ...props } />,
      <DateInput  index={index} initialValue={props['paidAt']} update={update} name='paidAt' suggestions={props.suggestions.paidAt} />,
    ]
  } else {
    fieldNodes = [
      <p>{props['description']}</p>,
      <p>{props['category']}</p>,
      <p>{props['amount']}</p>,
      <p>{props['paidAt']}</p>,
    ]
  }

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
          {
            fieldNodes.map((node, i) => (<li className={"request-item__li"} key={i}>{ node }</li>))
          }
        </ul>
      </div>
    </div>
  );
}

RequestItem.propTypes = {
  description: PropTypes.shape({
    val: PropTypes.string,
    error: PropTypes.string,
  }),
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
    <div className="request-item__input-group">
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
    </div>
  );
}

function BasicInput({ name, title, type, update, index, val, error}) {
  const wrapperClass = classnames('request-item__input-group', { 'has-error': error });
  return (
    <div className={wrapperClass}>
      <label>{title}</label>
      <input
        className={"request-item__input"}
        type={"text"}
        placeholder={title}
        value={val}
        onChange={(e) => {
          update({ [name]: e.target.value }, index)
        }}
      />
      { error ? (<p className="text-danger">{ error }</p>) : null }
    </div>
  )
}

function Dropdown({ name, title, update, index, ...props}) {
  let optionNodes = options().map(({ name, value }) => {
    return (
      <option value={value} key={value}>{name}</option>
    )
  })

  return (
    <div className="request-item__input-group">
      <label>{title}</label>
      <select
        className={"request-item__input"}
        value={props[name]}
        onChange={(e) => {
          update({ [name]: e.target.value }, index)
        }}
        required
      >
        { optionNodes }
      </select>
    </div>
  );
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
