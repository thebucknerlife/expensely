import React, { PropTypes } from "react";
import { get, find, without } from "lodash";
import moment from 'moment';
import DatePicker from 'react-datepicker';
//import 'react-datepicker-css';

const railsFormat = 'YYYY-MM-DD';
const displayFormat = "MM/DD/YY";

export default function DateInput({ name, initialValue, update, index, suggestions }) {
  let date = moment(initialValue, railsFormat);

  console.log('DateInput initialValue', initialValue);
  console.log('DateInput date', date);
  console.log('DateInput suggestions', suggestions);

  if (!date.isValid()) {
    date = null;
  }

  const _update = function(momentVal) {
    update({ [name]: momentVal.format(railsFormat) }, index)
  }

  const otherSuggestions = without(suggestions, initialValue);

  return (
    <div>
      <DatePicker
        key={name}
        className={"request-item__input"}
        dateFormat={displayFormat}
        selected={date}
        onChange={_update}
      />
      <SuggestedDates suggestions={otherSuggestions} selfDate={date} _update={_update}/>
    </div>
  );
}

function SuggestedDates({ suggestions, selfDate, _update }) {
  if (suggestions.length == 0) return null;

  return (
    <div className="date-input__suggestions">
      Suggestions: { suggestions.map((date) => <SuggestedDate date={date} _update={_update} /> ) }
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
