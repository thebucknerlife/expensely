import { union, compact } from 'lodash';

export function reqSugs(request) {
  let base = { paidAt: [] };
  request.requestItems.reduce((suggestions, item) => {
    if (item.paidAt) {
      suggestions.paidAt = compact(union(suggestions['paidAt'], [item.paidAt.val]));
    }
    return suggestions;
  }, base);
  return base;
}

