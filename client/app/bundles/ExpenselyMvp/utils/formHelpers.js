import { reduce } from 'lodash';

export function formDataFromRequest(requestAttrs) {
  let formAttrs = Object.assign({}, requestAttrs);
  const reqItemAttrs = requestAttrs.requestItems.map((item) => {
    return {
      amount:       item.amount,
      category:     { val: item.category },
      description:  { val: item.description },
      id:           item.id,
      paidAt:       item.paidAt,
      receiptId:    item.receiptId,
      receipt:      item.receipt,
      _destroy:     item._destroy,
      _destroy:     item._destroy,
    }
  });
  formAttrs.requestItems = reqItemAttrs;
  return formAttrs;
}

export function validateAndSetErrors(formData) {
  const newReqItems = formData.requestItems.map((item) => {
    if(!item.description.val) {
      item.description.error = 'Can not be blank';
    } else {
      item.description.error = undefined;
    }

    if(item.category.val === 'none') {
      item.category.error = 'Please select a category';
    } else {
      item.category.error = undefined;
    }

    //if(!item.amount.val <= 0) {
      //item.amount.error = 'Must be greater than 0';
    //} else {
      //item.amount.error = undefined;
    //}

    //if(!item.category.val === 'none') {
      //item.category.error = 'Please select a category';
    //} else {
      //item.category.error = undefined;
    //}
    return item;
  })

  return Object.assign(formData, { requestItems: newReqItems });
}

export function hasErrors(formData) {
    return reduce(formData.requestItems, (bool, item) => {
      if(item.description.error || item.category.error || item.amount.error || item.paidAt.error) {
        return bool || true;
      } else {
        return bool || false;
      }
    }, false);
}
