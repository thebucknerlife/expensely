import { union, compact } from 'lodash';

export function reqSugs(request) {
  let base = { paidAt: [] };
  request.requestItems.reduce((sug, item) => {
    sug['paidAt'] = compact(union(sug['paidAt'], [item.paidAt.val]));
    return sug;
  }, base);
  return base;
}

