var unsorted = [5, 2, 6, 1];
var sorted = [1, 2, 3, 25];

var msLogic = function(left, right, arr){
    var l = 0, r = 0, k = 0;
    while (l < left.length && r < right.length){
        if (left[l] < right[r]) {
            arr[k] = left[l]
            k++
            l++
        } else {
            arr[k] = right[r]
            k++
            r++
        }
    };
    while (l < left.length){
        arr[k] = left[l]
        k++
        l++
    };    
    while (r < right.length){
        arr[k] = right[r]
        k++
        r++
    };
    return arr
};

var ms = function(arr){
    if (arr.length == 1) return arr;
    var left = [], right = [];
    var middex = Math.floor(arr.length / 2);
    for (var i = 0; i < middex; i++){
        left.push(arr[i])
    };
    for (var i = middex; i < arr.length; i++){
        right.push(arr[i])
    };
    ms(left);
    ms(right);
    return msLogic(left, right, arr);
};

var insertion = function(arr){
    for (var i = 1; i < arr.length; i++){
        var j = i; element = arr[i]
        while ((j > 0) && (arr[j-1] > element)){
            arr[j] = arr[j-1]
            j--
        };
        arr[j] = element
    };
    return arr;
};

var partition = function(arr, startDex, endDex){
    var pivot = arr[endDex], pDex = startDex
    for (var i = startDex; i < endDex; i++){
        if (arr[i] <= pivot){
            var temp = arr[i]
            arr[i] = arr[pDex]
            arr[pDex] = temp
            pDex++
            //console.log("inside")
        }
    }
    var temp = arr[pDex]
    arr[pDex] = pivot
    arr[endDex] = temp
    //console.log(arr)
    return pDex
};

var quickSort = function(arr, startDex, endDex){
    if (typeof startDex === "undefined"){
        var startDex = 0; endDex = arr.length-1
    }
    if (endDex > startDex){
        pDex = partition(arr, startDex, endDex)
        console.log(pDex-1)
        quickSort(arr, startDex, pDex-1)
        quickSort(arr, pDex+1, endDex)
    }
    return arr
}


console.log(quickSort(unsorted))