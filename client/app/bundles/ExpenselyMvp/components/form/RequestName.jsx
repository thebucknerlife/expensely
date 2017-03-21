import React, { PropTypes } from 'react';

export default function RequestName({ submittable, request, updateRequest }) {
  if (submittable) {
    return (
      <input
        className="name form-control"
        type="text"
        placeholder="What is the name of your reimbursement request?"
        value={request.name}
        onChange={(e) => {
          updateRequest({ name: e.target.value })
        }}
      />
    )
  } else {
    return <h3>{request.name}</h3>
  }
}
