import React, { PropTypes } from 'react';
import DirtyNotice from './DirtyNotice';

export default function Submit({ submittable, handleSave, handleSubmit, dirty }) {
  if (!submittable) { return <span> This reimbursement has been submitted!  </span>}

  return (
    <div className="submit-container">
      <DirtyNotice dirty={dirty} />
      <input
        className={"btn btn-primary btn-lrg"}
        type="submit"
        value="Save"
        onClick={handleSave}
      />
      <input
        className={"btn btn-success btn-lrg"}
        type="submit"
        value="Submit For Reimbursement"
        onClick={handleSubmit}
      />
    </div>
  );
}
