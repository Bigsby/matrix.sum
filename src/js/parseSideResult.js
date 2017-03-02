module.exports = function(value){
    if (typeof value === "number"){
        this.success = true;
        this.side = value;
    }else{
        this.success = false;
        this.errorMessage = value;
    }
}