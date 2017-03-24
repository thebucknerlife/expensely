import React, { PropTypes } from "react";
import { get, find, without } from "lodash";
import moment from 'moment';
import DatePicker from 'react-datepicker';
import classnames from 'classnames';
//import 'react-datepicker-css';

const railsFormat = 'YYYY-MM-DD';
const displayFormat = "MM/DD/YY";

export default function DateInput({ name, update, index, suggestions, data }) {
  let date = moment(data.val, railsFormat);

  if (!date.isValid()) {
    date = null;
  }

  const _update = function(momentVal) {
    update({ [name]: { val: momentVal.format(railsFormat) } }, index);
  }

  const otherSuggestions = without(suggestions, data.val);
  const wrapperClass = classnames('request-item__input-group', { 'has-error': data.error });

  return (
    <div className={wrapperClass}>
      <label>Date</label>
      <DatePicker
        key={name}
        className={"request-item__input"}
        dateFormat={displayFormat}
        selected={date}
        onChange={_update}
      />
      { data.error ? (<p className="text-danger">{ data.error }</p>) : null }
      <SuggestedDates suggestions={otherSuggestions} selfDate={date} _update={_update} key='suggestions'/>
    </div>
  );
}

function SuggestedDates({ suggestions, selfDate, _update }) {
  if (suggestions.length == 0) return null;

  return (
    <div className="date-input__suggestions">
      Suggestions: { suggestions.map((date) => <SuggestedDate date={date} key={date} _update={_update} /> ) }
    </div>
  );
}

function SuggestedDate({date, _update}) {
  const momentDate = moment(date, railsFormat);
  return(
    <button
      className="date-input__suggestion-date"
      onClick={(e) => {
        e.preventDefault();
        _update(momentDate);
      }}
    >
      { momentDate.format(displayFormat) }
    </button>
  )
}
