

This repository
Explore
Gist
Blog
Help
ellawren
 Watch
Star 1,528Fork 417PUBLIC GBKS/Wookmark-jQuery
 branch: master  Wookmark-jQuery / jquery.wookmark.js 
 Sebobo 15 days ago Placeholders are now behind tiles in filter example. Top tile positio…
9 contributors                  
 file 440 lines (369 sloc) 14.715 kb EditRawBlameHistory Delete
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
/*!
  jQuery Wookmark plugin
  @name jquery.wookmark.js
  @author Christoph Ono (chri@sto.ph or @gbks)
  @author Sebastian Helzle (sebastian@helzle.net or @sebobo)
  @version 1.3.0
  @date 6/27/2013
  @category jQuery plugin
  @copyright (c) 2009-2013 Christoph Ono (www.wookmark.com)
  @license Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) license.
*/
(function (factory) {
  if (typeof define === 'function' && define.amd)
    define(['jquery'], factory);
  else
    factory(jQuery);
}(function ($) {

  var Wookmark, defaultOptions, __bind;

  __bind = function(fn, me) {
    return function() {
      return fn.apply(me, arguments);
    };
  };

  // Wookmark default options
  defaultOptions = {
    align: 'center',
    container: $('body'),
    offset: 2,
    autoResize: false,
    itemWidth: 0,
    flexibleWidth: 0,
    resizeDelay: 50,
    onLayoutChanged: undefined,
    fillEmptySpace: false
  };

  Wookmark = (function(options) {

    function Wookmark(handler, options) {
      // Instance variables.
      this.handler = handler;
      this.columns = this.containerWidth = this.resizeTimer = null;
      this.activeItemCount = 0;
      this.direction = 'left';
      this.itemHeightsDirty = true;
      this.placeholders = [];

      $.extend(true, this, defaultOptions, options);

      // Bind instance methods
      this.update = __bind(this.update, this);
      this.onResize = __bind(this.onResize, this);
      this.onRefresh = __bind(this.onRefresh, this);
      this.getItemWidth = __bind(this.getItemWidth, this);
      this.layout = __bind(this.layout, this);
      this.layoutFull = __bind(this.layoutFull, this);
      this.layoutColumns = __bind(this.layoutColumns, this);
      this.filter = __bind(this.filter, this);
      this.clear = __bind(this.clear, this);
      this.getActiveItems = __bind(this.getActiveItems, this);
      this.refreshPlaceholders = __bind(this.refreshPlaceholders, this);

      // Collect filter data
      var i = j = 0, filterClasses = {}, itemFilterClasses;

      for (; i < handler.length; i++) {
        $item = handler.eq(i);

        // Read filter classes
        itemFilterClasses = $item.data('filterClass');

        // Globally store each filter class as object and the fitting items in the array
        if (typeof itemFilterClasses == 'object' && itemFilterClasses.length > 0) {
          for (j = 0; j < itemFilterClasses.length; j++) {
            filterClass = $.trim(itemFilterClasses[j]).toLowerCase();

            if (!(filterClass in filterClasses)) {
              filterClasses[filterClass] = [];
            }
            filterClasses[filterClass].push($item[0]);
          }
        }
      };
      this.filterClasses = filterClasses;

      // Listen to resize event if requested.
      if (this.autoResize) {
        $(window).bind('resize.wookmark', this.onResize);
      };
      this.container.bind('refreshWookmark', this.onRefresh);
    };

    // Method for updating the plugins options
    Wookmark.prototype.update = function(options) {
      this.itemHeightsDirty = true;
      $.extend(true, this, options);
    };

    // This timer ensures that layout is not continuously called as window is being dragged.
    Wookmark.prototype.onResize = function() {
      clearTimeout(this.resizeTimer);
      this.itemHeightsDirty = this.flexibleWidth != 0;
      this.resizeTimer = setTimeout(this.layout, this.resizeDelay);
    };

    // Marks the items heights as dirty and does a relayout
    Wookmark.prototype.onRefresh = function() {
      this.itemHeightsDirty = true;
      this.layout();
    };

    /**
     * Filters the active items with the given string filters.
     * @param filters array of string
     * @param mode 'or' or 'and'
     */
    Wookmark.prototype.filter = function(filters, mode) {
      var activeFilters = [], activeFiltersLength, activeItems = $(),
          i, j, k, filter;

      filters = filters || [];
      mode = mode || 'or';

      if (filters.length) {
        // Collect active filters
        for (i = 0; i < filters.length; i++) {
          filter = $.trim(filters[i].toLowerCase());
          if (filter in this.filterClasses) {
            activeFilters.push(this.filterClasses[filter]);
          }
        }

        // Get items for active filters with the selected mode
        activeFiltersLength = activeFilters.length
        if (mode == 'or' || activeFiltersLength == 1) {
          // Set all items in all active filters active
          for (i = 0; i < activeFiltersLength; i++) {
            activeItems = activeItems.add(activeFilters[i]);
          }
        } else if (mode == 'and') {
          var shortestFilter = activeFilters[0],
              itemValid = true, foundInFilter,
              currentItem, currentFilter;

          // Find shortest filter class
          for (i = 1; i < activeFiltersLength; i++) {
            if (activeFilters[i].length < shortestFilter.length) {
              shortestFilter = activeFilters[i];
            }
          }

          // Iterate over shortest filter and find elements in other filter classes
          for (i = 0; i < shortestFilter.length; i++) {
            currentItem = shortestFilter[i];
            itemValid = true;

            for (j = 0; j < activeFilters.length && itemValid; j++) {
              currentFilter = activeFilters[j];
              if (shortestFilter == currentFilter) continue;

              // Search for current item in each active filter class
              for (k = 0, foundInFilter = false; k < currentFilter.length && !foundInFilter; k++) {
                foundInFilter = currentFilter[k] == currentItem;
              }
              itemValid &= foundInFilter;
            }
            itemValid && activeItems.push(shortestFilter[i]);
          }
        }
        // Hide inactive items
        this.handler.not(activeItems).addClass('inactive');
      } else {
        // Show all items if no filter is selected
        activeItems = this.handler;
      }

      // Show active items
      activeItems.removeClass('inactive');

      // Unset columns and refresh grid for a full layout
      this.columns = null;
      this.layout();
    };

    /**
     * Creates or updates existing placeholders to create columns of even height
     */
    Wookmark.prototype.refreshPlaceholders = function(columnWidth, sideOffset) {
      var i = this.placeholders.length,
          $placeholder, $lastColumnItem,
          columnsLength = this.columns.length, column,
          placeholderBorderWidth,
          height, width, top,
          containerHeight = this.container.outerHeight();

      for (; i < columnsLength; i++) {
        $placeholder = $('<div class="wookmark-placeholder"/>').appendTo(this.container);
        this.placeholders.push($placeholder);
      }

      innerOffset = this.offset + parseInt(this.placeholders[0].css('borderWidth')) * 2;

      for (i = 0; i < this.placeholders.length; i++) {
        $placeholder = this.placeholders[i];
        column = this.columns[i];

        if (i >= columnsLength || !column[column.length - 1]) {
          $placeholder.css('display', 'none');
        } else {
          $lastColumnItem = column[column.length - 1];
          if (!$lastColumnItem) continue;
          top = $lastColumnItem.data('wookmark-top') + $lastColumnItem.data('wookmark-height') + this.offset;
          height = containerHeight - top - innerOffset;

          $placeholder.css({
            position: 'absolute',
            display: height > 0 ? 'block' : 'none',
            left: i * columnWidth + sideOffset,
            top: top,
            width: columnWidth - innerOffset,
            height: height
          });
        }
      }
    };

    // Method the get active items which are not disabled and visible
    Wookmark.prototype.getActiveItems = function() {
      return this.handler.not('.inactive');
    };

    // Method to get the standard item width
    Wookmark.prototype.getItemWidth = function() {
      var itemWidth = this.itemWidth,
          containerWidth = this.container.width(),
          firstElement = this.handler.eq(0),
          flexibleWidth = this.flexibleWidth;

      if (this.itemWidth === undefined || this.itemWidth === 0 && !this.flexibleWidth) {
        itemWidth = firstElement.outerWidth();
      }
      else if (typeof this.itemWidth == 'string' && this.itemWidth.indexOf('%') >= 0) {
        itemWidth = parseFloat(this.itemWidth) / 100 * containerWidth;
      }

      // Calculate flexible item width if option is set
      if (flexibleWidth) {
        if (typeof flexibleWidth == 'string' && flexibleWidth.indexOf('%') >= 0) {
          flexibleWidth = parseFloat(flexibleWidth) / 100 * containerWidth
            - firstElement.outerWidth() + firstElement.innerWidth();
        }

        var columns = ~~(1 + containerWidth / (flexibleWidth + this.offset)),
            columnWidth = (containerWidth - (columns - 1) * this.offset) / columns;

        itemWidth = Math.max(itemWidth, ~~(columnWidth));

        // Stretch items to fill calculated width
        this.handler.css('width', itemWidth);
      }

      return itemWidth;
    };

    // Main layout method.
    Wookmark.prototype.layout = function() {
      // Do nothing if container isn't visible
      if (!this.container.is(":visible")) return;

      // Calculate basic layout parameters.
      var columnWidth = this.getItemWidth() + this.offset,
          containerWidth = this.container.width(),
          columns = ~~((containerWidth + this.offset) / columnWidth),
          offset = maxHeight = i = 0,
          activeItems = this.getActiveItems(),
          activeItemsLength = activeItems.length,
          $item;

      // Cache item height
      if (this.itemHeightsDirty) {
        for (; i < activeItemsLength; i++) {
          $item = activeItems.eq(i);
          $item.data('wookmark-height', $item.outerHeight());
        }
        this.itemHeightsDirty = false;
      }

      // Use less columns if there are to few items
      columns = Math.max(1, Math.min(columns, activeItemsLength));

      // Calculate the offset based on the alignment of columns to the parent container
      if (this.align == 'left' || this.align == 'right') {
        offset = ~~((columns / columnWidth + this.offset) >> 1);
      } else {
        offset = ~~(.5 + (containerWidth - (columns * columnWidth - this.offset)) >> 1);
      }

      // Get direction for positioning
      this.direction = this.align == 'right' ? 'right' : 'left';

      // If container and column count hasn't changed, we can only update the columns.
      if (this.columns != null && this.columns.length == columns && this.activeItemCount == activeItemsLength) {
        maxHeight = this.layoutColumns(columnWidth, offset);
      } else {
        maxHeight = this.layoutFull(columnWidth, columns, offset);
      }
      this.activeItemCount = activeItemsLength;

      // Set container height to height of the grid.
      this.container.css('height', maxHeight);

      // Update placeholders
      if (this.fillEmptySpace) {
        this.refreshPlaceholders(columnWidth, offset);
      }

      if (this.onLayoutChanged !== undefined && typeof this.onLayoutChanged === 'function') {
        this.onLayoutChanged();
      }
    };

    /**
     * Perform a full layout update.
     */
    Wookmark.prototype.layoutFull = function(columnWidth, columns, offset) {
      var item, top, left, i = 0, k = 0 , j = 0,
          activeItems = this.getActiveItems(),
          length = activeItems.length,
          shortest = null, shortestIndex = null,
          itemCSS = {position: 'absolute'},
          sideOffset, heights = [],
          leftAligned = this.align == 'left' ? true : false;

      this.columns = [];

      // Prepare arrays to store height of columns and items.
      while (heights.length < columns) {
        heights.push(0);
        this.columns.push([]);
      }

      // Loop over items.
      for (; i < length; i++ ) {
        $item = activeItems.eq(i);

        // Find the shortest column.
        shortest = heights[0];
        shortestIndex = 0;
        for (k = 0; k < columns; k++) {
          if (heights[k] < shortest) {
            shortest = heights[k];
            shortestIndex = k;
          }
        }

        // stick to left side if alignment is left and this is the first column
        if (shortestIndex == 0 && leftAligned) {
          sideOffset = 0;
        } else {
          sideOffset = shortestIndex * columnWidth + offset;
        }

        // Position the item.
        itemCSS[this.direction] = sideOffset;
        itemCSS.top = shortest;
        $item.css(itemCSS).data('wookmark-top', shortest);

        // Update column height and store item in shortest column
        heights[shortestIndex] += $item.data('wookmark-height') + this.offset;
        this.columns[shortestIndex].push($item);
      }

      // Return longest column
      return Math.max.apply(Math, heights);
    };

    /**
     * This layout method only updates the vertical position of the
     * existing column assignments.
     */
    Wookmark.prototype.layoutColumns = function(columnWidth, offset) {
      var heights = [],
          i = 0, k = 0,
          column, item, itemCSS, sideOffset;

      for (; i < this.columns.length; i++) {
        heights.push(0);
        column = this.columns[i];
        sideOffset = i * columnWidth + offset;
        currentHeight = heights[i];

        for (k = 0; k < column.length; k++) {
          $item = column[k];
          itemCSS = {
            top: currentHeight
          };
          itemCSS[this.direction] = sideOffset;

          $item.css(itemCSS).data('wookmark-top', currentHeight);

          currentHeight += $item.data('wookmark-height') + this.offset;
        }
        heights[i] = currentHeight;
      }

      // Return longest column
      return Math.max.apply(Math, heights);
    };

    /**
     * Clear event listeners and time outs.
     */
    Wookmark.prototype.clear = function() {
      clearTimeout(this.resizeTimer);
      $(window).unbind('resize.wookmark', this.onResize);
      this.container.unbind('refreshWookmark', this.onRefresh);
    };

    return Wookmark;
  })();

  $.fn.wookmark = function(options) {
    // Create a wookmark instance if not available
    if (!this.wookmarkInstance) {
      this.wookmarkInstance = new Wookmark(this, options || {});
    } else {
      this.wookmarkInstance.update(options || {});
    }

    // Apply layout
    this.wookmarkInstance.layout();

    // Display items (if hidden) and return jQuery object to maintain chainability
    return this.show();
  };
}));
Status API Training Shop Blog About © 2013 GitHub, Inc. Terms Privacy Security Contact 