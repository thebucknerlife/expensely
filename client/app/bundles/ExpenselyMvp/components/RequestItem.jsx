import React, { PropTypes } from "react";
import classnames from 'classnames';
import moment from 'moment';
import { get, find, capitalize } from "lodash";
import Image from './Image';
import DateInput from './DateInput';

const RequestItem = ({index, update, submittable, ...props}) => {
  let fieldNodes;

  if (submittable) {
    fieldNodes = [
      <BasicInput index={index} key='description' update={update} title='Description' name='description' data={props.description}/>,
      <Dropdown   index={index} key='category'    update={update} title='Category'    name='category'    data={props.category} { ...props } />,
      <MoneyInput index={index} key='amount'      update={update} title='Amount'      name='amount'     data={props.amount} />,
      <DateInput  index={index} update={update} name='paidAt' suggestions={props.suggestions.paidAt} data={props.paidAt} />,
    ]
  } else {
    fieldNodes = [
      <SubmittedField data={props.description} title='Description'/>,
      <SubmittedField data={props.category} title='Category' type='category'/>,
      <SubmittedField data={props.amount} title='Amount' type='money'/>,
      <SubmittedField data={props.paidAt} title='Date' type='date'/>,
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
        { submittable &&
          <div className={"request-item__delete"}>
            <span className={"delete-icon"} onClick={() => { props.delete(index) }}>&#10006;</span>
          </div>
        }
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
  amount: PropTypes.shape({
    val: PropTypes.number,
    error: PropTypes.string,
  }),
  update: PropTypes.func.isRequired,
};

RequestItem.defaultProps = {
  description: "",
  category: "",
  amount: 0
}

export default RequestItem;

function MoneyInput({ name, title, type, update, index, data }) {
  let value = data.val / 100;
  const wrapperClass = classnames('request-item__input-group', { 'has-error': data.error });

  return (
    <div className={wrapperClass}>
      <label>{title}</label>
      <input
        className={"request-item__input"}
        type={"number"}
        placeholder={title}
        value={value}
        onChange={(e) => {
          update({ [name]: { val: (e.target.value * 100) } }, index)
        }}
      />
      { data.error ? (<p className="text-danger">{ data.error }</p>) : null }
    </div>
  );
}

function BasicInput({ name, title, type, update, index, data}) {
  const wrapperClass = classnames('request-item__input-group', { 'has-error': data.error });

  return (
    <div className={wrapperClass}>
      <label>{title}</label>
      <input
        className={"request-item__input"}
        type={"text"}
        placeholder={title}
        value={data.val}
        onChange={(e) => {
          update({ [name]: { val: e.target.value } }, index)
        }}
      />
      { data.error ? (<p className="text-danger">{ data.error }</p>) : null }
    </div>
  )
}

function Dropdown({ name, title, update, index, data, ...props}) {
  const wrapperClass = classnames('request-item__input-group', { 'has-error': data.error });
  let optionNodes = options().map(({ name, value }) => {
    return (
      <option value={value} key={value}>{name}</option>
    )
  })

  return (
    <div className={wrapperClass}>
      <label>{title}</label>
      <select
        className={"request-item__input"}
        value={data.val}
        onChange={(e) => {
          update({ [name]: { val: e.target.value } }, index)
        }}
        required
      >
        { optionNodes }
      </select>
      { data.error ? (<p className="text-danger">{ data.error }</p>) : null }
    </div>
  );
}

function SubmittedField({title, data, type}) {
  let displayValue;

  switch(type) {
    case 'date':
      const date = moment(data.val, 'YYYY-MM-DD');
      displayValue = date.format("MM/DD/YY")
      break;
    case 'money':
      displayValue = '$' + (data.val / 100).toFixed(2);
      break;
    case 'category':
      displayValue = capitalize(data.val);
      break;
    default:
      displayValue = data.val;
  }
  return(
    <div className="request_item__submitted-field">
      <label>{ title }</label>
      <div>{ displayValue }</div>
    </div>
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
