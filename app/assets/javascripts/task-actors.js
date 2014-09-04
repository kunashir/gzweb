function TaskActor(name) {
    var $this = this;

    $this.name = name;
    $this.checkbox = $("." + name + "-selector");
    $this.input = $("." + name + "-row");
    $this.link = $(".actor-selector." + name);

    var inputTableRow = $this.input.closest("tr");
    var inputEdit = $this.input.find(".edit-lookup-multi");

    function update() {
        inputTableRow.css("display", $this.isSet() ? "table-row" : "none");
        $this.link.css("display", $this.isSet() ? "none" : "initial");
    }

    $this.isSet = function(name) {
        return $this.checkbox.prop("checked");
    }

    $this.set = function () {
        $this.checkbox.prop("checked", true);
        update();
    }

    $this.reset = function () {
        $this.checkbox.prop("checked", false);
        update();
    }

    $this.disable = function () {
        $this.checkbox.attr("disabled", true);
        $this.link.css("display", "none");
    }

    $this.enable = function () {
        $this.checkbox.attr("disabled", false);
        update();
    }

    $this.focus = function() {
        $this.input.find(".edit-lookup-multi").lookupMulti("focus");
    }

    $this.checkbox.change(function (e) {
        e.preventDefault();
        update();
    });

    $this.link.click(function (e) {
        $this.set();
        $this.focus();
        $this.link.css("display", "none");
    });

    update();
}

function TaskActors(name) {
    if (name == "create") {
        var $this = this;

        $this.actors = [ 
            new TaskActor("co_performers"), 
            new TaskActor("informants"),
            new TaskActor("controller") ]

        $this.actor = function(name) {
            if (typeof(name) == "string") {
                for (var i = 0; i < $this.actors.length; i++)
                    if ($this.actors[i].name == name)
                        return $this.actors[i];
                return null;
            }
            return name;
        }

        $this.reset = function () {
            $this.actors.forEach(function (a) { a.reset(); });
        }
        
        $this.init = function () {}
    }
    else
    if (name) {
        return TaskActors().actor(name);
    }
    else {
        if (!window.$actors)
            window.$actors = new TaskActors("create");
        return window.$actors;
    }
}

$(function () {
    TaskActors().init();
});