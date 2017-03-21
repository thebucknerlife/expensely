import { reduce } from 'lodash';

export function reqAttrsToFormAttrs(requestAttrs) {
  let formAttrs = Object.assign({}, requestAttrs);
  const reqItemAttrs = requestAttrs.requestItems.map((item) => {
    return {
      amount:       item.amount,
      category:     item.category,
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

export function invalidate(formAttrs) {
  let invalidAttrs = Object.assign({}, formAttrs);

  invalidAttrs.requestItems.forEach((item) => {

    if (!item.description.val) {
      console.log('error');
      item.error = "Cannot be blank";
    } else {
      item.error = undefined;
    }

  });

  const isInvalid = reduce(invalidAttrs.requestItems, (item) => {
    return item.error ? true : false;
  }, false)

  return isInvalid ? invalidAttrs : false;
}
