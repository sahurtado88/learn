# terraform

Terraform Code Configuration block types include:

Terraform Settings Block
Terraform Provider Block
Terraform Resource Block
Terraform Data Block
Terraform Input Variables Block
Terraform Local Variables Block
Terraform Output Values Block
Terraform Modules Block

If you ever would like to know which providers are installed in your working directory and those required by the configuration, you can issue a terraform version and terraform providers command.




________


En Terraform, la tilde (~) en la salida de terraform plan indica un cambio planeado pero no aplicado. Esto significa que Terraform detectó un cambio en la configuración que necesita ser aplicado, pero debido a diversas razones, como dependencias o restricciones de estado, el cambio no se aplicará directamente en esta ejecución.

Por lo general, esto ocurre cuando se modifica un recurso y Terraform determina que el cambio no puede aplicarse de manera independiente, sino que depende de otros recursos que también necesitan cambios. Terraform mostrará estos cambios planeados con tilde (~) para informarte de que se ha detectado un cambio, pero no se aplicará inmediatamente debido a su dependencia de otros cambios.

Por ejemplo, si modificas un recurso de red y también cambias la configuración de un recurso de instancia, Terraform mostrará ambos cambios planeados con una tilde (~) para indicar que están relacionados y que se aplicarán juntos en la siguiente ejecución. Esto ayuda a entender las relaciones entre los recursos y cómo se aplicarán los cambios en conjunto.

_______________

Comenzando con la estructuración de la configuración de Terraform
Poner todo el código en main.tf es una buena idea de cuando estás comenzando o escribiendo un código ejemplo. Para cualquier otro caso será mejor tener varios archivos en una separación lógica como a continuación se presenta:

main.tf - llama a los módulos, locals y data-sources para crear todos los recursos.

variables.tf - contiene declaraciones de variables utilizadas en el main.tf.

outputs.tf - contiene outputs de recursos creados en main.tf.

versions.tf - contiene requerimientos de versión para Terraform y proveedores.

terraform.tfvars no debe ser utilizado en ningún otro lugar más que en la composición.