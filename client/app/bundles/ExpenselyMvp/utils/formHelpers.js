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
    }
  });
  formAttrs.requestItems = reqItemAttrs;
  return formAttrs;
}
