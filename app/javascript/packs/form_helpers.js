document.addEventListener('turbolinks:load', ()=>{
    // adder = document.getElementById('add_field_button')
    // adder = adder.getElementsByTagName('a')[0]
    // adder.addEventListener('click', ()=>{
    //     c = document.getElementsByClassName('nested-fields').length
    //     console.log(c)
    //     node = document.getElementsByClassName('nested-fields')[0]
    //     console.log(node)
    // })
    function all_field_type_setting(){
        p = document.getElementsByClassName('nested-fields')
        p.forEach((node, index, array)=>{
            field_type_setting(node)
        })
    }
    function field_type_setting(node){
        value = node.getElementsByTagName('select')[0].value
        if(value=="TextField" || value=="TextArea"){
            parent.node('#form_field').style.display="block"
            parent.node('#form_field_option').style.display="none"
        }else if(value=="Radio" || value=="CheckBox"){
            parent.node('#form_field').style.display="block"
            parent.node('#form_field_option').style.display="block"
        }else{
            parent.node('#form_field').style.display="none"
            parent.node('#form_field_option').style.display="none"
        }
    }
    // all_field_type_setting();
    document.body.addEventListener('click', (event)=>{
        parent = event.target.parentNode
        if(parent.id=="field_type"){
            field = event.target.value
            parent = parent.parentNode
            console.log('parent')
            console.log(parent)
            if(field=="TextField" || field=="TextArea" || field=="DateField" || field=="FileField"){
                parent.querySelector('#form_field').style.display="block"
                parent.querySelector('#form_field_option').style.display="none"
            }else if(field=="Radio" || field=="CheckBox"){
                parent.querySelector('#form_field').style.display="block"
                parent.querySelector('#form_field_option').style.display="block"
            }else{
                parent.querySelector('#form_field').style.display="none"
                parent.querySelector('#form_field_option').style.display="none"
            }
        }
        if(event.target.id=="add-radio-option"){
            form_id = document.getElementById('form-id').value
            radio_id = document.getElementById('radio-obj').value
            console.log(radio_id)
            $.ajax({
                url: '/forms/'+form_id+'/radio_fields/add_radio_option',
                method: "POST",
                data: { "form_id": form_id, "radio_id": radio_id },
                success:(response)=>{
                    var div = document.createElement('div')
                    div.innerHTML = response
                    $('#radio-option-section').append(div)
                    $('.delete-radio-option').on('click', (event)=>{
                        event.target.parentNode.remove()
                    })
                },
                error:(XMLHttpRequest, textStatus, errorThrown)=>{
                    console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
                }
            })
            
        }
    })
    $('#add_field').on('click', ()=>{
        // console.log(document.getElementById('form_field_type').value)
        // f = document.getElementById('form_field_type')
        // a = document.getElementById('add_field')
        // a.setAttribute("data-association-insertion-node", f.value)
    })
    $('#form-submit').on('click', (event)=>{
        event.preventDefault()
        console.log('form submitted')
        forms = document.forms
        Array.from(forms).forEach((form)=>{
            console.log(form)
            fd = new FormData(form)
            entries = Object.fromEntries(fd)
            // setTimeout(()=>{
            $.ajax({
                url: form.getAttribute('action'),
                method: "POST",
                data: entries,
                success:(response)=>{
                    console.log('success')
                },
                error:(XMLHttpRequest, textStatus, errorThrown)=>{
                    console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
                }
            })
            // }, 000)
        })
        console.log('finished')
        setTimeout(()=>{
            window.location.reload()
        }, 2000)
    })
    $('#new-field').on('click', ()=>{
        temp = document.getElementById('form-fields')
        type = document.getElementById('to-be-added-field').value
        form_id = document.getElementById('form-id').value
        $.ajax({
            url: '/forms/'+form_id+'/add_new_field',
            method: "POST",
            data: {"type": type, "id":form_id },
            success:(response)=>{
                var div = document.createElement('div')
                div.innerHTML = response
                console.log('success')
                temp.append(div)
            },
            error:(XMLHttpRequest, textStatus, errorThrown)=>{
                console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
            }
        })
    })
    
})